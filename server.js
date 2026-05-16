const express = require('express');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.static('public'));

const isMac = process.platform === 'darwin';

// Detect active sessions and their foreground processes
function getActiveSessions() {
    const sessions = [];
    try {
        let devices = [];
        if (isMac) {
            // macOS uses /dev/ttysXXX
            const devFiles = fs.readdirSync('/dev');
            devices = devFiles.filter(f => f.startsWith('ttys') && !isNaN(f.replace('ttys', ''))).map(f => `tty${f.replace('tty', '')}`);
        } else {
            // Linux uses /dev/pts/X
            devices = fs.readdirSync('/dev/pts').filter(f => !isNaN(f)).map(f => `pts/${f}`);
        }
        
        for (const device of devices) {
            try {
                // Find foreground process
                // Linux uses '+', macOS state often includes '+' for foreground
                const psCmd = isMac 
                    ? `ps -t ${device} -o state,comm,args --no-headers`
                    : `ps -t ${device} -o stat,comm,args --no-headers`;
                
                const output = execSync(psCmd, { encoding: 'utf8' });
                const lines = output.trim().split('\n');
                
                let foregroundProc = 'bash'; // default
                let bestMatch = null;

                for (const line of lines) {
                    const parts = line.trim().split(/\s+/);
                    if (parts.length < 3) continue;
                    
                    const stat = parts[0];
                    const comm = path.basename(parts[1]); // Ensure we just get the name
                    const args = parts.slice(2).join(' ');

                    if (stat.includes('+')) {
                        // If it's a generic node/python process, look at the arguments
                        if (comm.toLowerCase().includes('node') || comm.toLowerCase().includes('python')) {
                            if (args.includes('gemini')) {
                                bestMatch = 'gemini';
                            } else if (args.includes('hermes')) {
                                bestMatch = 'hermes';
                            } else {
                                bestMatch = comm;
                            }
                        } else {
                            bestMatch = comm;
                        }
                    }
                }
                
                if (bestMatch) foregroundProc = bestMatch;
                sessions.push({ pts: device, process: foregroundProc });
            } catch (e) {
                // Fallback for restricted/closed devices
                sessions.push({ pts: device, process: 'bash' });
            }
        }
    } catch (e) {
        console.error('Error scanning devices:', e);
    }
    return sessions;
}

app.get('/api/sessions', (req, res) => {
    res.json(getActiveSessions());
});

app.get('/api/commands/:context', (req, res) => {
    const context = req.params.context.toLowerCase();
    const filePath = path.join(__dirname, 'commands', `${context}.json`);
    
    if (fs.existsSync(filePath)) {
        const data = fs.readFileSync(filePath, 'utf8');
        res.json(JSON.parse(data));
    } else {
        // Fallback to bash if context not found
        const bashPath = path.join(__dirname, 'commands', 'bash.json');
        if (fs.existsSync(bashPath)) {
            const data = fs.readFileSync(bashPath, 'utf8');
            res.json(JSON.parse(data));
        } else {
            res.json([]);
        }
    }
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});

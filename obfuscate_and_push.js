const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const sourceFile = path.join(__dirname, 'Source', 'ArsenalHub.lua');

if (!fs.existsSync(sourceFile)) {
    console.error('Source file not found:', sourceFile);
    process.exit(1);
}

// 1. Read clean source code
const originalCode = fs.readFileSync(sourceFile, 'utf8');

// Convert code bytes directly to standard string.char(...) calls array for 100% stable execution
const buffer = Buffer.from(originalCode, 'utf8');
const byteList = [];
for (let i = 0; i < buffer.length; i++) {
    byteList.push(buffer[i]);
}

// Luau Loader Wrapper that rebuilds the exact string from byte array
const loaderCode = `-- [ Arsenal Hub Obfuscated Build ]
local bytes = {${byteList.join(',')}}
local chars = {}
for i = 1, #bytes do
    chars[i] = string.char(bytes[i])
end

local code = table.concat(chars)
local func, err = loadstring(code)
if func then
    func()
else
    warn("[ArsenalHub Loader Error]: " .. tostring(err))
end
`;

console.log('Obfuscating ArsenalHub.lua for GitHub release...');
fs.writeFileSync(sourceFile, loaderCode, 'utf8');

try {
    console.log('Staging files...');
    execSync('git add .');
    
    console.log('Committing changes...');
    execSync('git commit -m "build: publish obfuscated release"');
    
    console.log('Pushing to GitHub...');
    execSync('git push -u origin main');
    
    console.log('Successfully obfuscated & pushed to Git!');
} catch (error) {
    console.error('Git push failed:', error.message);
} finally {
    // Restore clean original source code locally
    fs.writeFileSync(sourceFile, originalCode, 'utf8');
    console.log('Restored clean source code locally in workspace.');
}

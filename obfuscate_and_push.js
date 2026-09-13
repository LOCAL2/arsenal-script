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

// 2. Simple Obfuscation / Encoding Wrapper (XOR + Base64)
const key = 0x5F; // XOR key
const buffer = Buffer.from(originalCode, 'utf8');
const obfuscatedBytes = [];

for (let i = 0; i < buffer.length; i++) {
    obfuscatedBytes.push(buffer[i] ^ key);
}

const base64Data = Buffer.from(obfuscatedBytes).toString('base64');

// Luau Loader Wrapper that decodes and executes dynamically
const loaderCode = `-- [ Arsenal Hub Obfuscated Build ]
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local encoded = "${base64Data}"
local raw = dec(encoded)
local bytes = {}
for i = 1, #raw do
    local byte = string.byte(raw, i, i)
    table.insert(bytes, string.char(bit32.bxor(byte, ${key})))
end

local code = table.concat(bytes)
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

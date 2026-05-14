const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const apk = 'android/app/build/outputs/apk/release/app-release.apk';
const resDir = 'android/app/build/generated/res/react/release';
const densities = ['drawable-mdpi', 'drawable-xhdpi', 'drawable-xxhdpi', 'drawable-xxxhdpi'];

// Use jar to add files to APK
let count = 0;
densities.forEach(density => {
  const dir = path.join(resDir, density);
  if (fs.existsSync(dir)) {
    const files = fs.readdirSync(dir);
    files.forEach(file => {
      const filePath = path.join(dir, file);
      const entryName = `res/${density}/${file}`;
      try {
        // Use 7zip or jar to add
        execSync(`"C:\\Program Files\\Java\\jdk-17\\bin\\jar.exe" uf ${apk} -C ${path.dirname(filePath)} ${path.basename(filePath)}`, {
          cwd: process.cwd(),
          stdio: 'pipe'
        });
        count++;
        console.log('Added: ' + entryName);
      } catch(e) {
        console.log('Error adding ' + file + ': ' + e.message);
      }
    });
  }
});
console.log('Total injected: ' + count);

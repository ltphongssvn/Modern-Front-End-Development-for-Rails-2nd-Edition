# Manufacturing ERP Dashboard

### Sprint 1 - Task Failures & Resolutions

#### Failed: Rails 8 App Creation with Yarn 0.32+git
**Error:** Rails 8 Dockerfile generation failed - couldn't parse Yarn version "0.32+git"
**Root Cause:** Ubuntu's cmdtest package provided conflicting /usr/bin/yarn binary
**Resolution Steps:**
1. Removed npm global yarn: `npm uninstall -g yarn`
2. Removed cmdtest: `sudo apt remove cmdtest -y`
3. Enabled Corepack: `corepack enable`
4. Installed Yarn 4.11.0: `corepack prepare yarn@stable --activate`
**Result:** ✅ Yarn upgraded to 4.11.0

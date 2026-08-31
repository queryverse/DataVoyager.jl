# Allow Chromium's sandbox to work on GitHub's Ubuntu runners.
#
# Ubuntu 24.04 restricts unprivileged user namespaces via AppArmor, which
# makes the Electron/Chromium versions resolved on older Julia legs abort
# with "The SUID sandbox helper binary was found, but is not configured
# correctly". Lifting the restriction lets Chromium use the user-namespace
# sandbox instead of the setuid helper.
if Sys.islinux()
    run(`sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0`)
end

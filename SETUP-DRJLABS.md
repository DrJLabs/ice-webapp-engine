# DrJLabs Organization Setup Guide

This guide outlines the steps to transfer the repository to DrJLabs organization and configure the organization-wide runners.

## 🔄 Repository Transfer

### Step 1: Manual Transfer via GitHub UI

**❗ Important: This step must be done manually via GitHub web interface.**

1. Navigate to: [https://github.com/DrJsPBs/Next-js-Boilerplate/settings](https://github.com/DrJsPBs/Next-js-Boilerplate/settings)
2. Scroll to the **"Danger Zone"** section at the bottom
3. Click **"Transfer"**
4. In the transfer dialog:
   - **New owner**: Enter `DrJLabs`
   - **Repository name** (optional): Change to `ice-webapp-engine`
   - Type the repository name to confirm: `Next-js-Boilerplate`
5. Click **"I understand, transfer this repository"**

### Step 2: Update Local Git Remote

After transfer, update your local repository:

```bash
git remote set-url origin git@github.com:DrJLabs/ice-webapp-engine.git
# or for HTTPS:
# git remote set-url origin https://github.com/DrJLabs/ice-webapp-engine.git

# Verify the change
git remote -v
```

## 🏃‍♂️ Organization Runner Configuration

### Expected Runner Labels in DrJLabs

Based on ice-webapp configuration, the following runner labels should be available:

| Label | Purpose | Used By |
|-------|---------|---------|
| `self-hosted, linux` | Basic organization runners | All workflows (fallback) |
| `self-hosted, linux, quality` | Code quality and linting | Fast CI quality checks |
| `self-hosted, linux, build` | Application building | Fast CI build jobs |
| `self-hosted, linux, test` | General testing | Unit tests |
| `self-hosted, linux, test, parallel` | Parallel test execution | Unit tests with parallelization |
| `self-hosted, linux, test, e2e` | End-to-end testing | Heavy CI E2E tests |
| `self-hosted, linux, security` | Security scanning | Security audits |
| `self-hosted, linux, performance` | Performance testing | Lighthouse audits |
| `self-hosted, linux, test, mutation` | Mutation testing | Heavy CI mutation tests |

### Runner Requirements

Each runner should have:

- **Ubuntu 22.04+** (for libasound2t64 support)
- **Node.js 22.x**
- **Docker** (for security scanning)
- **Chrome/Chromium** (for E2E and performance tests)
- **Sufficient RAM**: 8GB+ for build runners, 16GB+ for E2E runners
- **Fast SSD storage** with tmpfs support
- **Network access** to GitHub API and npm registry

### Verifying Runner Setup

After repository transfer, test the runners:

1. Go to **Actions** tab in the transferred repository
2. Run the **"Test DrJLabs Organization Runners"** workflow manually
3. Check which specialized runners are available
4. Review the diagnostic output

## 🔧 CI/CD Workflows

### Available Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| **CI (Fast)** | Push/PR to main/develop | Quick quality checks, build, unit tests |
| **CI (Heavy)** | Push to main | E2E tests, performance audits, mutation testing |
| **Test DrJLabs Runners** | Manual only | Diagnose runner availability |

### Workflow Optimizations

Our workflows include several optimizations for organization runners:

- **Ephemeral tmpfs storage** for build isolation
- **Aggressive cleanup** to prevent runner pollution
- **Specialized runner targeting** for optimal performance
- **Parallel execution** where possible
- **Resource-aware timeouts** based on runner capabilities

## 🚀 Getting Started

### After Repository Transfer

1. **Test runner connectivity**:
   ```bash
   # In the transferred repository
   gh workflow run "Test DrJLabs Organization Runners"
   ```

2. **Run initial CI**:
   ```bash
   # Push a small change to trigger CI
   git commit --allow-empty -m "test: trigger CI after DrJLabs transfer"
   git push
   ```

3. **Monitor workflow execution**:
   - Check the Actions tab for any runner issues
   - Verify all specialized runners are accessible
   - Review execution times and resource usage

### Expected Improvements

With DrJLabs organization runners, you should see:

- ✅ **Faster CI execution** due to specialized runners
- ✅ **Better resource isolation** with tmpfs storage
- ✅ **Parallel test execution** capabilities
- ✅ **Dedicated runners** for different workload types
- ✅ **Consistent environment** across all workflows

## 🔍 Troubleshooting

### Common Issues

1. **Runner not found**: Check runner labels and availability in DrJLabs organization settings
2. **Permission denied**: Ensure repository has access to organization runner groups
3. **Build failures**: Check Node.js version and dependency installation
4. **E2E test failures**: Verify Chrome/Chromium installation on E2E runners

### Debug Commands

```bash
# Check current repository settings
gh repo view --json owner,name,isInOrganization

# List available runners (organization admin only)
gh api /orgs/DrJLabs/actions/runners

# Check workflow runs
gh run list --limit 5
```

## 📋 Checklist

- [ ] Repository transferred to DrJLabs organization
- [ ] Local git remote updated
- [ ] Runner connectivity test passed
- [ ] Fast CI workflow executed successfully
- [ ] Heavy CI workflow executed successfully (optional)
- [ ] All specialized runners accessible
- [ ] Team members have appropriate access

---

**Next Steps**: Once setup is complete, you can start building applications using the optimized CI/CD pipeline with DrJLabs organization runners! 
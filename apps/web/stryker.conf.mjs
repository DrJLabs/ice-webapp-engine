// @ts-check

/** @type {import('@stryker-mutator/api/core').PartialStrykerOptions} */
const config = {
  packageManager: "npm",
  reporters: ["html", "clear-text", "progress", "dashboard"],
  testRunner: "vitest",
  vitest: {
    configFile: "vitest.config.mts",
  },
  coverageAnalysis: "perTest",
  mutate: [
    "src/**/*.{js,jsx,ts,tsx}",
    "!src/**/*.{test,spec}.{js,jsx,ts,tsx}",
    "!src/**/*.d.ts",
    "!src/**/*.stories.{js,jsx,ts,tsx}",
    "!src/**/index.{js,jsx,ts,tsx}",
    "!src/**/__mocks__/**",
    "!src/**/__tests__/**",
    "!src/**/test-utils/**",
    "!src/**/setupTests.ts",
  ],
  buildCommand: "npm run build",
  ignorePatterns: [
    "node_modules",
    "dist",
    ".next",
    "coverage",
    "reports",
    "*.config.*",
    "*.d.ts",
  ],
  thresholds: {
    high: 80,
    low: 70,
    break: 65,
  },
  timeoutMS: 300000,
  maxConcurrentTestRunners: 2,
  htmlReporter: {
    fileName: "reports/mutation/mutation-report.html",
  },
  clearTextReporter: {
    allowColor: true,
    logTests: false,
    maxTestsToLog: 3,
  },
  dashboard: {
    project: "ice-webapp-engine",
    version: "main",
  },
  plugins: [
    "@stryker-mutator/vitest-runner",
  ],
};

export default config; 
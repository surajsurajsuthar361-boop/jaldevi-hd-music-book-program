import { configureGenkit } from '@genkit-ai/core';
import { firebase } from '@genkit-ai/firebase';
import { googleAI } from '@genkit-ai/google-genai';

configureGenkit({
  plugins: [
    firebase(),
    googleAI(),
  ],
  flowState: {
    provider: 'firebase',
  },
  traceStore: {
    provider: 'firebase',
  },
  logLevel: 'debug',
  enableTracingAndMetrics: true,
});

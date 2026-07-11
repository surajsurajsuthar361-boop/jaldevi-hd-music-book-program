import { run } from '@genkit-ai/core';
import { generateCustomQuoteFlow, suggestMenuFlow } from '../../../../src/ai/flows';

export async function POST(req: Request) {
  const { flow, ...input } = await req.json();

  let result;
  switch (flow) {
    case 'generateCustomQuote':
      result = await run(generateCustomQuoteFlow, input);
      break;
    case 'suggestMenu':
      result = await run(suggestMenuFlow, input);
      break;
    default:
      return new Response('Invalid flow', { status: 400 });
  }

  return new Response(JSON.stringify(result), {
    headers: { 'Content-Type': 'application/json' },
  });
}

import { defineFlow, run } from '@genkit-ai/flow';
import { z } from 'zod';
import { generate } from '@genkit-ai/ai';

const UserNeedsSchema = z.object({
  event_type: z.string(),
  guest_count: z.number(),
  decorations: z.array(z.string()),
  entertainment: z.array(z.string()),
});

const PriceQuoteSchema = z.object({
  price: z.number(),
  quote: z.string(),
});

export const generateCustomQuoteFlow = defineFlow(
  {
    name: 'generateCustomQuoteFlow',
    inputSchema: UserNeedsSchema,
    outputSchema: PriceQuoteSchema,
  },
  async (userNeeds) => {
    const prompt = `You are a party planner. A user is asking for a price quote for a custom party. Generate a custom quote based on their needs. The user\'s needs are: Event Type: ${userNeeds.event_type}, Guest Count: ${userNeeds.guest_count}, Decorations: ${userNeeds.decorations.join(', ')}, Entertainment: ${userNeeds.entertainment.join(', ')}. Please provide a price and a friendly message explaining the quote.`

    const llmResponse = await run('generate-llm-response', async () =>
      generate({
        model: 'google/gemini-pro',
        prompt: prompt,
        output: {
          schema: PriceQuoteSchema,
        },
      })
    );

    return llmResponse.output()!;
  },
);

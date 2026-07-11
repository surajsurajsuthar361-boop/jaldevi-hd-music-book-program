import { defineFlow, run } from '@genkit-ai/flow';
import { z } from 'zod';
import { generate } from '@genkit-ai/ai';

const MenuSuggestionRequestSchema = z.object({
  event_type: z.string(),
  guest_count: z.number(),
  dietary_restrictions: z.array(z.string()),
});

const MenuSuggestionSchema = z.object({
  suggestions: z.array(z.string()),
});

export const suggestMenuFlow = defineFlow(
  {
    name: 'suggestMenuFlow',
    inputSchema: MenuSuggestionRequestSchema,
    outputSchema: MenuSuggestionSchema,
  },
  async (request) => {
    const prompt = `You are a world-renowned chef. A user is asking for menu suggestions for a party. The user's needs are: Event Type: ${request.event_type}, Guest Count: ${request.guest_count}, Dietary Restrictions: ${request.dietary_restrictions.join(', ')}. Please provide a list of menu suggestions.`

    const llmResponse = await run('generate-llm-response', async () =>
      generate({
        model: 'google/gemini-pro',
        prompt: prompt,
        output: {
          schema: MenuSuggestionSchema,
        },
      })
    );

    return llmResponse.output()!;
  },
);

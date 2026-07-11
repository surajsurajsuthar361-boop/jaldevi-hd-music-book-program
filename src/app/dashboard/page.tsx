'use client';

import { useState } from 'react';

export default function DashboardPage() {
  const [eventType, setEventType] = useState('');
  const [guestCount, setGuestCount] = useState(0);
  const [dietaryRestrictions, setDietaryRestrictions] = useState<string[]>([]);

  const [quote, setQuote] = useState('');
  const [menuSuggestions, setMenuSuggestions] = useState<string[]>([]);

  const handleGetQuote = async () => {
    const response = await fetch('/api/ai', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        flow: 'generateCustomQuote',
        event_type: eventType,
        guest_count: guestCount,
        dietary_restrictions: dietaryRestrictions,
      }),
    });
    const result = await response.json();
    setQuote(result.quote);
  };

  const handleSuggestMenu = async () => {
    const response = await fetch('/api/ai', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        flow: 'suggestMenu',
        event_type: eventType,
        guest_count: guestCount,
        dietary_restrictions: dietaryRestrictions,
      }),
    });
    const result = await response.json();
    setMenuSuggestions(result.suggestions);
  };

  return (
    <div>
      <h1>Dashboard</h1>
      <div>
        <h2>Get a Custom Quote</h2>
        <input
          type="text"
          placeholder="Event Type"
          value={eventType}
          onChange={(e) => setEventType(e.target.value)}
        />
        <input
          type="number"
          placeholder="Guest Count"
          value={guestCount}
          onChange={(e) => setGuestCount(parseInt(e.target.value))}
        />
        <input
          type="text"
          placeholder="Dietary Restrictions (comma-separated)"
          onChange={(e) => setDietaryRestrictions(e.target.value.split(','))}
        />
        <button onClick={handleGetQuote}>Get Quote</button>
        {quote && <p>Quote: {quote}</p>}
      </div>
      <div>
        <h2>Get Menu Suggestions</h2>
        <button onClick={handleSuggestMenu}>Get Suggestions</button>
        {menuSuggestions.length > 0 && (
          <ul>
            {menuSuggestions.map((suggestion, index) => (
              <li key={index}>{suggestion}</li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}

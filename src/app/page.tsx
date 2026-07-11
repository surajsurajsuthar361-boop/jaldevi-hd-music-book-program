import Link from 'next/link';

export default function HomePage() {
  return (
    <div>
      <h1>Welcome to Party Planner</h1>
      <p>Plan your perfect party with us!</p>
      <Link href="/dashboard">Get a Quote</Link>
    </div>
  );
}

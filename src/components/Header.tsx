import Link from 'next/link';

const Header = () => (
  <header>
    <nav>
      <Link href="/">Home</Link>
      <Link href="/dashboard">Dashboard</Link>
    </nav>
  </header>
);

export default Header;

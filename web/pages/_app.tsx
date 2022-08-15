import '../styles/globals.css';
import type { AppProps } from 'next/app';
import { ThemeProvider } from 'next-theme';
import Head from 'next/head';

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ThemeProvider attribute="class">
      <Head>
        <title>moseoh</title>
        <meta name="description" content="연습용" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Component {...pageProps} />
    </ThemeProvider>
  );
}

export default MyApp;

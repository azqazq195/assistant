import Head from 'next/head';
import Layout from '../components/layout';
import Hero from '../components/home/hero';

export default function Home() {
  return (
    <Layout>
      <Head>
        <title>moseoh</title>
        <meta name="description" content="연습용" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Hero />
    </Layout>
  );
}

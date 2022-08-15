import type { NextPage } from 'next';
import Head from 'next/head';
import Hero from '../components/home/hero';
import Layout from '../components/layout';

const Home: NextPage = () => {
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
};

export default Home;

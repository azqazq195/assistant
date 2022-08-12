import Layout from '../components/layout';
import Head from 'next/head';

export default function () {
  return (
    <Layout>
      <Head>
        <title>moseoh</title>
        <meta name="description" content="연습용" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <h1>프로젝트</h1>
    </Layout>
  );
}

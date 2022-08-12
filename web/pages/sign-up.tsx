import Head from 'next/head';
import Link from 'next/dist/client/link';

export default function SignUp() {
  return (
    <>
      <Head>
        <title>moseoh</title>
        <meta name="description" content="로그인" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <section className="flex h-screen items-center justify-center ">
        <div className="flex flex-col min-h-screen items-center justify-center">
          <div className="w-96">
            <h2 className="text-gray-900 text-3xl font-bold mb-3 ">회원가입</h2>
            <div className="relative mb-3">
              <input
                type="email"
                id="email"
                name="email"
                placeholder="이메일"
                className="w-full text-xs bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200  outline-none text-gray-700 py-1 px-3 leading-7 transition-colors duration-200 ease-in-out"
              />
            </div>
            <div className="relative mb-3">
              <input
                type="password"
                id="password"
                name="password"
                placeholder="비밀번호"
                className="w-full text-xs bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200  outline-none text-gray-700 py-1 px-3 leading-7 transition-colors duration-200 ease-in-out"
              />
            </div>

            <div className="relative mb-3">
              <input
                type="password"
                id="password"
                name="password"
                placeholder="비밀번호 확인"
                className="w-full text-xs bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200  outline-none text-gray-700 py-1 px-3 leading-7 transition-colors duration-200 ease-in-out"
              />
            </div>

            <Link href="/sign-in">
              <button className="w-full text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg mb-1">
                회원가입
              </button>
            </Link>

            <p className="text-xs text-gray-500 mt-3">
              Copyright 2022. Moseoh all rights reserved.
            </p>
          </div>
        </div>
      </section>
    </>
  );
}

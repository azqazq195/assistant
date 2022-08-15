import Head from 'next/head';
import Link from 'next/dist/client/link';
import { useStoreSignIn } from './signInStore';
import SignUp from '../../components/signUp/signUp';

export default function SignIn() {
  const { showSignUp, setShowSignUp } = useStoreSignIn();

  return (
    <>
      <Head>
        <title>moseoh</title>
        <meta name="description" content="로그인" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      {showSignUp ? <SignUp /> : null}

      <section className="h-screen items-center justify-center grid grid-cols-2">
        <div className="flex flex-col min-h-screen items-center justify-center">
          <div className="w-96">
            <h2 className="text-gray-900 text-3xl font-bold mb-3 ">
              Assistant
            </h2>
            <p className="text-gray-500 text-xs font-medium mb-2">
              로그인 정보를 입력해 주세요.
            </p>
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

            <div className="flex items-center mb-10 justify-end">
              <input
                type="checkbox"
                className="w-4 h-4 rounded border-gray-300 focus:ring-indigo-500 "
              />
              <label className="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">
                자동 로그인
              </label>
            </div>

            <Link href="/">
              <div className="relative mb-3">
                <button className="w-full text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg">
                  로그인
                </button>
              </div>
            </Link>
            <button
              className="w-full text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
              onClick={() => setShowSignUp(true)}
            >
              회원가입
            </button>
            <p className="text-xs text-gray-500 mt-3">
              Copyright 2022. Moseoh all rights reserved.
            </p>
          </div>
        </div>
        <div className="flex min-h-screen items-center justify-center bg-indigo-100">
          <h1 className="text-5xl font-bold">CORNERSTONE</h1>
        </div>
      </section>
    </>
  );
}

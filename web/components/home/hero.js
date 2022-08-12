import Link from 'next/link';

export default function Hero() {
  return (
    <div className="container mx-auto flex px-5 py-24 md:flex-row flex-col items-center">
      <div className="lg:flex-grow md:w-1/2 lg:pr-24 md:pr-16 flex flex-col md:items-start md:text-left mb-16 md:mb-0 items-center text-center">
        <h1 className="title-font sm:text-4xl text-3xl mb-4 font-medium text-gray-900">
          Before they sold out
          <br className="hidden lg:inline-block" />
          readymade gluten
        </h1>
        <p className="mb-8 leading-relaxed">
          청춘의 청춘의 살았으며, 더운지라 그림자는 풍부하게 밝은 뿐이다. 공자는
          우리의 피고 거선의 물방아 아니한 밝은 피다. 있는 불어 가치를 전인
          설레는 이것을 그러므로 부패뿐이다. 살았으며, 피어나는 이상의 얼마나
          찾아 열락의 피가 청춘 힘있다.
        </p>
        <div className="flex justify-center">
          <Link href="/project">
            <a className="btn-project">프로젝트 보러가기</a>
          </Link>
        </div>
      </div>
      <div className="lg:max-w-lg lg:w-full md:w-1/2 w-5/6"></div>
    </div>
  );
}

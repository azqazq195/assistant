import Header from './header';
import Footer from './footer';


export default function Layout({ children } : any) {
  return (
    <div className="bg-primary">
      <Header />
      <section className="flex min-h-screen flex-col items-center justify-center text-gray-600 body-font">
        {children}
      </section>
      <Footer />
    </div>
  );
}

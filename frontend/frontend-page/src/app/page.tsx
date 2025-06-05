// app/page.tsx
import Introduction from './components/Introduction';
import Occupation from './components/Occupation';

export default function Home() {
	return (
		<main className='min-h-screen flex flex-col font-thin px-12 py-8 overflow-y-scroll snap-y scroll-hidden snap-mandatory gap-1'>
			{/* Introduction Section */}
			<section className='snap-start min-h-screen'>
				<Introduction />
			</section>

			{/* Occupation Section */}
			<section className='snap-start min-h-screen'>
				<Occupation />
			</section>
		</main>
	);
}

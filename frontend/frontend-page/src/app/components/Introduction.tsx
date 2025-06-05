// Inntrouction.tsx
import React from 'react';
import SocialIcons from './SocialIcons';

export default function Introduction() {
	return (
		<div className='md:my-28 min-h-screen flex-grow flex justify-between relative items-start gap-16 snap-start'>
			{/* Left Side - Intro */}
			<section className='max-w-xl space-y-6'>
				<h1 className='text-6xl font-extralight tracking-tight'>Welcome</h1>
				<p className='text-lg text-gray-300 leading-relaxed'>
					My name is Herwin Dermawan, I&apos;m a front-end developer and
					back-end developer. I still need to learn more about front-end and
					back-end, since I&apos;m still not confident with my skills.
				</p>
				<p className='text-lg text-gray-300 leading-relaxed'>
					I&apos;m passionate about problem solving, challenges, and learning
					about new things.
				</p>
			</section>

			{/* Right Side: Projects + SocialIcons */}
			<section className='w-80 flex flex-col justify-between h-full'>
				<div className='space-y-6'>
					<h2 className='text-2xl font-extralight tracking-tight'>Projects</h2>
					<ul className='space-y-3 text-gray-300 border-l border-gradient-to-br from-green-400 to-blue-400 pl-5'>
						{[
							'Virtual Reality',
							'Flutter',
							'Backend',
							'Illustration',
							'3D Modeling',
						].map((proj) => (
							<li key={proj}>
								<span className='border-b border-green-400 hover:text-white cursor-pointer'>
									{proj}
								</span>
							</li>
						))}
					</ul>
				</div>
			</section>

			{/* Social Medai Icons*/}
			<SocialIcons className='hidden md:flex flex-col items-center space-y-4 absolute -right-7 top-0' />
		</div>
	);
}

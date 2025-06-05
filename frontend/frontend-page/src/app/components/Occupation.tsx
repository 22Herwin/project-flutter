// components/Occupation.tsx
import React from 'react';

export default function Occupation() {
	return (
		<div className='md:-my-25 min-h-screen flex-grow flex justify-between items-start gap-16 snap-start border-t border-gray-600 pt-16'>
			{/* Left Side: Image or Placeholder */}
			<section className='w-80 h-80 bg-gray-700 flex items-center justify-center rounded-lg'>
				<span className='text-white'>[Image or Illustration]</span>
			</section>

			{/* Right Side: Occupation Info */}
			<section className='max-w-xl space-y-6'>
				<h1 className='text-6xl font-extralight tracking-tight'>Occupation</h1>
				<p className='text-lg text-gray-300 leading-relaxed'>
					I specialize in front-end and back-end development. I enjoy working on
					user-friendly interfaces and scalable back-end systems. My experience
					includes developing web applications, APIs, and mobile apps using
					modern frameworks.
				</p>
				<p className='text-lg text-gray-300 leading-relaxed'>
					My key skills include JavaScript, React, Node.js, Flutter, and more.
					I&apos;m passionate about continuous learning and taking on
					challenging projects.
				</p>
			</section>
		</div>
	);
}

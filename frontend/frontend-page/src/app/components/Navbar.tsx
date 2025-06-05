'use client';

import { motion, useScroll, useMotionValueEvent } from 'framer-motion';
import { useState } from 'react';

export default function Navbar() {
	const { scrollY } = useScroll();
	const [hidden, setHidden] = useState(true);

	useMotionValueEvent(scrollY, 'change', (latest) => {
		const previous = scrollY.getPrevious();
		if (latest > 100 && latest > previous!) {
			setHidden(false);
		} else {
			setHidden(true);
		}
	});

	return (
		<motion.nav
			initial={{ y: -100 }}
			animate={{ y: hidden ? -100 : 0 }}
			transition={{ duration: 0.3 }}
			className='fixed top-0 w-full bg-white/90 backdrop-blur-md z-50 shadow-sm'>
			<div className='container mx-auto px-6 py-4 flex justify-between items-center'>
				<span className='font-medium'>YourName</span>
				<div className='flex space-x-6'>
					{['About', 'Work', 'Contact'].map((item) => (
						<a
							key={item}
							href={`#${item.toLowerCase()}`}
							className='hover:text-gray-600 transition-colors'>
							{item}
						</a>
					))}
				</div>
			</div>
		</motion.nav>
	);
}

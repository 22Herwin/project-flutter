// app/layout.tsx
import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
	title: 'Herwin Dermawan - Front-end Developer',
	description: 'Front-end and Back-end developer',
};

export default function RootLayout({
	children,
}: {
	children: React.ReactNode;
}) {
	return (
		<html lang='en'>
			<body className='bg-[var(--background)] text-[var(--foreground)] min-h-screen'>
				<div className='m-[50px] bg-[var(--container)] p-8 md:p-12 rounded-lg h-[calc(100vh-100px)] w-[calc(100vw-100px)]'>
					{children}
				</div>
			</body>
		</html>
	);
}

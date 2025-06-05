import { FaGithub, FaLinkedin, FaInstagram, FaWhatsapp } from 'react-icons/fa';

export default function SocialIcons({ className = '' }) {
	return (
		<div className={`${className}`}>
			<a
				href='https://github.com/22Herwin'
				target='_blank'
				className='text-gray-500 hover:text-black transition-colors'>
				<FaGithub size={20} />
			</a>
			<a
				href='https://wa.link/9uzpyt'
				target='_blank'
				className='text-gray-500 hover:text-green-400 transition-colors'>
				<FaWhatsapp size={20} />
			</a>
			<a
				href='https://www.linkedin.com/in/herwin-dermawan-579894368/'
				target='_blank'
				className='text-gray-500 hover:text-blue-600 transition-colors'>
				<FaLinkedin size={20} />
			</a>
			<a
				href='https://www.instagram.com/hrwn._.porto'
				target='_blank'
				className='text-gray-500 hover:text-pink-500 transition-colors'>
				<FaInstagram size={20} />
			</a>
			<div className='h-16 w-px bg-gradient-to-b from-green-400 to-blue-400 mx-auto'></div>
		</div>
	);
}

import { v2 as cloudinary } from 'cloudinary';
import { envs } from './envs';

cloudinary.config({
	cloud_name: envs.CLOUDINARY_NAME,
	api_key: envs.CLOUDINARY_API_KEY,
	api_secret: envs.CLOUDINARY_API_SECRET
});

export default cloudinary;

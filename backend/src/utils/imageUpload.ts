import { CustomError } from './custom.error';
import cloudinary from '../config/cloudinary';
import { unlink } from 'fs/promises';

export const handleUpload = async (
	image: Express.Multer.File
): Promise<String> => {
	if (!image) {
		throw CustomError.badRequest('No se ingreso una imagen');
	}
	
	const local = `${image.destination}/${image.filename}`;

	const res = await cloudinary.uploader.upload(image.path);

	if (!res.secure_url) {
		throw CustomError.badRequest('No se pudo conectar con cloudinary');
	}

	await unlink(local);

	return res.secure_url;
};

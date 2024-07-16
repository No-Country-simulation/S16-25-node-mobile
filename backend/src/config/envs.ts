import 'dotenv/config';
import { get } from 'env-var';

export const envs = {
	PORT: get('PORT').required().asPortNumber(),
	MONGO_URL: get('MONGO_URL').required().asString(),
	MONGO_DB_NAME: get('MONGO_DB_NAME').required().asString(),
	JWT_SEED: get('JWT_SEED').required().asString(),
	CLOUDINARY_API_KEY: get('CLOUDINARY_API_KEY').required().asString(),
	CLOUDINARY_API_SECRET: get('CLOUDINARY_API_SECRET').required().asString(),
	CLOUDINARY_NAME: get('CLOUDINARY_NAME').required().asString()
};

import multer, { diskStorage } from 'multer';
import { existsSync, mkdirSync } from 'fs';
import { extname } from 'path';

const multerOptions = multer({
	limits: {
		fileSize: 50000000
	},
	fileFilter: (req: any, file: Express.Multer.File, cb: any) => {
		if (file.mimetype.match(/\/(jpg|jpeg|png)$/)) {
			cb(null, true);
		} else {
			cb('Invalid  image type', false);
		}
	},
	storage: diskStorage({
		destination: (req: any, file: Express.Multer.File, cb: any) => {
			const uploadPath = './public/images';
			if (!existsSync(uploadPath)) {
				mkdirSync(uploadPath);
			} else {
				cb(null, uploadPath);
			}
		},
		filename: (req: any, file: Express.Multer.File, cb: any) => {
			//${crypto.randomUUID()} Arreglar la version de node para usar randomUUID
			cb(null, `${Date.now()}${extname(file.originalname)}`);
		}
	})
});

export default multerOptions;

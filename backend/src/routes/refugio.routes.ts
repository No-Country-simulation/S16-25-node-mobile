import { Router } from 'express';
import { RefugioService } from '../services/refugio.service';
import { RefugioController } from '../controller/refugio.controller';
import upload from '../middlewares/handleFile';
import {
	bodyRefugioValidator,
	isMongoId,
	updateBodyRefugioValidator
} from '../middlewares/validators';

export class RefugioRouter {
	static get routes(): Router {
		const router = Router();
		const refugioService = new RefugioService();
		const controller = new RefugioController(refugioService);

		router.get('/', controller.getAll);
		router.post(
			'/',
			upload.single('image'),
			bodyRefugioValidator,
			controller.create
		);
		router.get('/:id', isMongoId, controller.getById);
		router.put(
			'/:id',
			upload.single('image'),
			isMongoId,
			updateBodyRefugioValidator,
			controller.update
		);
		router.delete('/:id', isMongoId, controller.delete);

		return router;
	}
}

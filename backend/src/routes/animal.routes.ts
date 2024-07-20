import { Router } from 'express';
import { AnimalController } from '../controller/animal.controller';
import { AnimalService } from '../services/animal.service';
import upload from '../middlewares/handleFile';
import { HandleInputErrors } from '../middlewares/validateInput';
import { bodyAnimalValidator, isMongoId } from '../middlewares/validators';

export class AnimalRouter {
	static get routes(): Router {
		const router = Router();
		const animalService = new AnimalService();
		const controller = new AnimalController(animalService);

		router.get('/', controller.getAll);
		router.post(
			'/',
			upload.single('image'),
			bodyAnimalValidator,
			HandleInputErrors,
			controller.create
		);
		router.get('/:id', isMongoId, HandleInputErrors, controller.getById);

		return router;
	}
}

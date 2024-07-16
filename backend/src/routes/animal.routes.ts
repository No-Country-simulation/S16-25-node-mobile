import { Router } from 'express';
import { AnimalController } from '../controller/animal.controller';
import { AnimalService } from '../services/animal.service';
import upload from '../middlewares/handleFile';
import { body } from 'express-validator';
import { HandleInputErrors } from '../middlewares/validateInput';

export class AnimalRouter {
	static get routes(): Router {
		const router = Router();
		const animalService = new AnimalService();
		const controller = new AnimalController(animalService);

		router.get('/', controller.get);
		router.post(
			'/',
			upload.single('image'),
			body('nombre')
				.notEmpty()
				.withMessage('El campo nombre no puede ir vació')
				.isString()
				.withMessage('El campo nombre debe ser un string'),
			body('especie')
				.notEmpty()
				.withMessage('El campo especie no puede ir vació')
				.isString()
				.withMessage('El campo especie debe ser un string'),
			body('edad')
				.notEmpty()
				.withMessage('El campo edad no puede ir vació')
				.isInt()
				.withMessage('El campo edad es un entero'),
			body('peso')
				.notEmpty()
				.withMessage('El campo peso no puede ir vació')
				.isInt()
				.withMessage('El campo peso es un enter'),
			body('estado').optional().isIn(['Activo', 'Pedido', 'Adoptado']),
			HandleInputErrors,
			controller.create
		);

		return router;
	}
}

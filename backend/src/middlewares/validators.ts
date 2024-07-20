import { body, param } from 'express-validator';

/* Animal Route Validator */
export const bodyAnimalValidator = [
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
	body('estado').optional().isIn(['Activo', 'Pedido', 'Adoptado'])
];

export const isMongoId = [
	param('id')
		.isMongoId()
		.withMessage('El id a buscar debe ser un Object de id de Mongo')
];

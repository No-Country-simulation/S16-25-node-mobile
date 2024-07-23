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

export const updateBodyAnimalValidator = [
	body('nombre')
		.optional()
		.isString()
		.withMessage('El campo nombre debe ser un string'),
	body('especie')
		.optional()
		.isString()
		.withMessage('El campo especie debe ser un string'),
	body('edad').optional().isInt().withMessage('El campo edad es un entero'),
	body('peso').optional().isInt().withMessage('El campo peso es un enter'),
	body('estado').optional().isIn(['Activo', 'Pedido', 'Adoptado'])
];

// Valiaciones para usuario
export const loginUserValidator = [
	body('email')
		.notEmpty()
		.withMessage('El campo email no puede estar vacío')
		.isEmail()
		.withMessage('El campo email debe ser un email'),
		//TODO: chequear contraseña
	body('password')
		.notEmpty()
		.withMessage('El campo password no puede estar vacío')
		.isString()
		.withMessage('El campo password debe ser una cadena de texto'),
]
export const registerUserValidator = [
    body('nombre')
        .notEmpty()
        .withMessage('El campo nombre no puede estar vacío')
        .isString()
        .withMessage('El campo nombre debe ser una cadena de texto'),
    body('fechaDeNacimiento')
        .notEmpty()
        .withMessage('El campo fecha de nacimiento no puede estar vacío')
        .isDate()
        .withMessage('El campo fecha de nacimiento debe ser una fecha válida'),
    body('rol')
        .notEmpty()
        .withMessage('El campo rol no puede estar vacío')
        .isIn(['Admin', 'User', 'Gerente'])
        .withMessage('El campo rol debe ser uno de los siguientes: Admin, User, Gerente'),
    body('telefono')
        .notEmpty()
        .withMessage('El campo teléfono no puede estar vacío')
        .isInt({ min: 0 })
        .withMessage('El campo teléfono debe ser un número entero positivo'),
    body('email')
        .notEmpty()
        .withMessage('El campo email no puede estar vacío')
        .isEmail()
        .withMessage('El campo email debe ser una dirección de correo electrónico válida'),
		//TODO: chequear password y el formato
    body('password')
        .notEmpty()
        .withMessage('El campo contraseña no puede estar vacío')
        .isLength({ min: 6 })
        .withMessage('La contraseña debe tener al menos 6 caracteres'),
    body('direccion')
        .notEmpty()
        .withMessage('El campo dirección no puede estar vacío')
        .isString()
        .withMessage('El campo dirección debe ser una cadena de texto'),
];

// Validaciones para la actualización de usuario
export const updateUserValidator = [
    body('nombre')
        .optional()
        .isString()
        .withMessage('El campo nombre debe ser una cadena de texto'),
    body('fechaDeNacimiento')
        .optional()
        .isDate()
        .withMessage('El campo fecha de nacimiento debe ser una fecha válida'),
    body('rol')
        .optional()
        .isIn(['Admin', 'User', 'Gerente'])
        .withMessage('El campo rol debe ser uno de los siguientes: Admin, User, Gerente'),
    body('telefono')
        .optional()
        .isInt({ min: 0 })
        .withMessage('El campo teléfono debe ser un número entero positivo'),
    body('email')
        .optional()
        .isEmail()
        .withMessage('El campo email debe ser una dirección de correo electrónico válida'),
		//TODO: chequear password y el formato
    body('password')
        .optional()
        .isLength({ min: 6 })
        .withMessage('La contraseña debe tener al menos 6 caracteres'),
    body('direccion')
        .optional()
        .isString()
        .withMessage('El campo dirección debe ser una cadena de texto'),
];

export const isMongoId = [
	param('id')
		.isMongoId()
		.withMessage('El id a buscar debe ser un Object de id de Mongo')
];

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

/* Calificacion */
export const bodyRatingValidator = [
	body('rate')
		.notEmpty()
		.withMessage('La Calificacion no puede ir vacía')
		.isInt({ min: 1, max: 5 })
		.withMessage('La calificación solo puede ser de 1 a 5'),
	body('texto')
		.notEmpty()
		.withMessage('El texto no puede ir vacío')
		.isString()
		.withMessage('El texto debe ser del tipo string'),
	body('user')
		.notEmpty()
		.withMessage('El user no debe ir vació')
		.isMongoId()
		.withMessage('debe ser un id de mongo valido'),
	body('refugio')
		.notEmpty()
		.withMessage('El refugio no debe ir vació')
		.isMongoId()
		.withMessage('debe ser un id de mongo valido')
];

export const updateBodyRatingValidator = [
	body('rate')
		.optional()
		.isInt({ min: 1, max: 5 })
		.withMessage('La calificación solo puede ser de 1 a 5'),
	body('texto')
		.optional()
		.isString()
		.withMessage('El texto debe ser del tipo string'),
	body('user')
		.optional()
		.isMongoId()
		.withMessage('debe ser un id de mongo valido'),
	body('refugio')
		.optional()
		.isMongoId()
		.withMessage('debe ser un id de mongo valido')
];

/* Refugio */

export const bodyRefugioValidator = [
	body('nombre')
		.notEmpty()
		.withMessage('El campo nombre no puede ir vació')
		.isString()
		.withMessage('El nombre del refugio debe ser un texto'),
	body('image').notEmpty().withMessage('El campo image no puede ir vació'),
	body('correo')
		.notEmpty()
		.withMessage('El campo correo no puede ir vació')
		.isEmail()
		.withMessage('El correo debe tener un formato valido'),
	body('telefono')
		.notEmpty()
		.withMessage('El campo telefono no puede ir vació')
		.isMobilePhone(['es-AR', 'es-PE'])
		.withMessage('El telefono debe tener un formato valido'),
	body('gerente')
		.notEmpty()
		.withMessage('El campo gerente no puede ir vació')
		.isMongoId()
		.withMessage('El gerente debe ser un id de mongo valido')
];

export const updateBodyRefugioValidator = [
	body('nombre')
		.optional()
		.isString()
		.withMessage('El nombre del refugio debe ser un texto'),
	body('image').optional(),
	body('correo')
		.optional()
		.isEmail()
		.withMessage('El correo debe tener un formato valido'),
	body('telefono')
		.optional()
		.isMobilePhone(['es-AR', 'es-PE'])
		.withMessage('El telefono debe tener un formato valido'),
	body('gerente')
		.optional()
		.isMongoId()
		.withMessage('El gerente debe ser un id de mongo valido')
];

/* Publicaciones */

export const bodyPostValidator = [
	body('titulo')
		.notEmpty()
		.withMessage('El titulo no puede ir vació')
		.isString()
		.withMessage('El el formato debe ser de texto'),
	body('texto')
		.notEmpty()
		.withMessage('El texto no puede ir vació')
		.isString()
		.withMessage('El el formato debe ser de texto'),
	body('image').optional(),
	body('status')
		.optional()
		.isIn(['ACTIVO', 'INACTIVO'])
		.withMessage('El status solo puede ser ACTIVO o INACTIVO'),
	body('refugio')
		.notEmpty()
		.withMessage('El campo refugio no puede ir vació')
		.isMongoId()
		.withMessage('El campo refugio debe ser un id de mongo valido')
];

export const updateBodyPostValidator = [
	body('titulo')
		.optional()
		.isString()
		.withMessage('El el formato debe ser de texto'),
	body('texto')
		.optional()
		.isString()
		.withMessage('El el formato debe ser de texto'),
	body('image').optional(),
	body('status')
		.optional()
		.isIn(['ACTIVO', 'INACTIVO'])
		.withMessage('El status solo puede ser ACTIVO o INACTIVO'),
	body('refugio')
		.optional()
		.isMongoId()
		.withMessage('El campo refugio debe ser un id de mongo valido')
];

// Validaciones para usuario
export const loginUserValidator = [
	body('email')
		.notEmpty()
		.withMessage('El campo email no puede estar vacío')
		.isEmail()
		.withMessage('El campo email debe ser un email'),
	body('password')
		.notEmpty()
		.withMessage('El campo password no puede estar vacío')
];
export const registerUserValidator = [
	body('nombre')
		.notEmpty()
		.withMessage('El campo nombre no puede estar vacío')
		.isString()
		.withMessage('El campo nombre debe ser una cadena de texto'),
		
        //solo registrar los datos email, password, tipo dni y numero dni
	/* body('fechaDeNacimiento')
		.notEmpty()
		.withMessage('El campo fecha de nacimiento no puede estar vacío')
		.isDate()
		.withMessage('El campo fecha de nacimiento debe ser una fecha válida'),
	/*  */body('rol')
		/* .notEmpty()
		.withMessage('El campo rol no puede estar vacío') */
		.isIn(['User'])
		.withMessage(
			'El campo rol debe ser User'
		),
	/* body('telefono')
		.notEmpty()
		.withMessage('El campo teléfono no puede estar vacío')
		.isInt({ min: 0 })
		.withMessage('El campo teléfono debe ser un número entero positivo'), */
	body('email')
		.notEmpty()
		.withMessage('El campo email no puede estar vacío')
		.isEmail()
		.withMessage(
			'El campo email debe ser una dirección de correo electrónico válida'
		),
	body('password')
		.notEmpty()
		.withMessage('El campo contraseña no puede estar vacío')
		//.matches(/^(?=.*\d)(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=\S+$).{8,}$/)
		//.withMessage('La contraseña debe tener al menos 8 caracteres, contener al menos un número, una letra mayúscula, un carácter especial y no tener espacios'),
	/* body('direccion')
		.notEmpty()
		.withMessage('El campo dirección no puede estar vacío')
		.isString()
		.withMessage('El campo dirección debe ser una cadena de texto') */
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
		.withMessage(
			'El campo rol debe ser uno de los siguientes: Admin, User, Gerente'
		),
	body('telefono')
		.optional()
		.isInt({ min: 0 })
		.withMessage('El campo teléfono debe ser un número entero positivo'),
	body('email')
		.optional()
		.isEmail()
		.withMessage(
			'El campo email debe ser una dirección de correo electrónico válida'
		),
	//TODO: chequear password y el formato
	body('password')
		.notEmpty()
		.withMessage('El campo contraseña no puede estar vacío')
		.matches(/^(?=.*\d)(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=\S+$).{8,}$/)
		.withMessage('La contraseña debe tener al menos 8 caracteres, contener al menos un número, una letra mayúscula, un carácter especial y no tener espacios'),
	body('direccion')
		.optional()
		.isString()
		.withMessage('El campo dirección debe ser una cadena de texto')
];

export const isMongoId = [
	param('id')
		.isMongoId()
		.withMessage('El id a buscar debe ser un Object de id de Mongo')
];

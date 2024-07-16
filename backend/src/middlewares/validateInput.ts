import { Request, Response, NextFunction } from 'express';
import { validationResult } from 'express-validator';

export const HandleInputErrors = (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	let errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(400).json({ errors: errors.array() });
	} else {
		next();
	}
};

import { NextFunction, Request, Response } from 'express';
import passport from "passport"
import { User } from '../models/user.model';

export const checkToken = (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate('jwt', { session: false }, (err: any, user: User, info: any) => {
        if (err) return res.status(401).json({ error: 'Error de autenticación' });
        if (!user) return res.status(401).json({ error: 'Acceso denegado' });

        req.user = user;
        next();
    })(req, res, next);
};
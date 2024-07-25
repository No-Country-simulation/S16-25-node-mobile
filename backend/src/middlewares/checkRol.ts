import { NextFunction, Request, Response } from "express"
import { envs } from "../config/envs"
import passport from "passport"
import { User } from "../models/user.model"

const { JWT_SEED } = envs

if (!JWT_SEED) {
    throw new Error('JWT_SEED no esta definido')
}

export const checkRol = (roles: string[] = []) => (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate('jwt', { session: false }, (err: any, user: User, info: any) => {
        if (err || !user) {
            return res.status(401).json({ message: 'No autenticado' })
        }
        if (!roles.includes(user.rol)) {
            return res.status(403).json({ message: 'No tienes permisos suficientes' })
        }

        req.user = user

        next()
    })(req, res, next)
}
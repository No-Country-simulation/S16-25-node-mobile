import { envs } from '../config/envs';
import { Strategy, ExtractJwt } from 'passport-jwt';
import passport from 'passport';
import { UserModel } from '../models/user.model';

const JWT_SECRET = envs.JWT_SEED;

// Configuración de Passport con estrategia de verificación por token para usar con autorización Bearer.
const opt = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: JWT_SECRET
};

passport.use(
    new Strategy(opt, async (payload, done) => {
        const user = await UserModel.findById(payload.id);
        if (user) {
            return done(null, user);
        } else {
            return done(null, false);
        }
    })
)
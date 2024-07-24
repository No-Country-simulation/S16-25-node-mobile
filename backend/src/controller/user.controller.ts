import { Response } from "express";
import { UserService } from "../services/user.service";
import { CustomError } from "../utils/custom.error";

export class UserController {

    constructor(private readonly userService: UserService ) {}

    private handleError = (error: unknown, res: Response) => {
        if (error instanceof CustomError) {
            return res.status(error.statusCode).json({ message: error.message });
        } else {
            console.log(`${error}`);
            return res.status(500).json({ error: 'Internal server error' });
        }
    };

    getAll =  (req: any, res: Response) => {
        this.userService.getUsers()
            .then(users => res.json(users))
            .catch(error => this.handleError(error, res));
    }

    getById = (req: any, res: Response) => {
        const { id } = req.params;

        this.userService.getById(id)
            .then(user => res.json(user))
            .catch(error => this.handleError(error, res));
    }

    /* register = (req: any, res: Response) => {
        const { body } = req;
        body.image = req.file;
        this.userService.create(body)
            .then(user => res.status(201).json(user))
            .catch(error => this.handleError(error, res));
    } */

    update = (req: any, res: Response) => {
        const { id } = req.params;
        const { body } = req;
        body.image = req.file;
        this.userService.update(id, body)
            .then(user => res.status(202).json(user))
            .catch(error => this.handleError(error, res));
    }

    delete = (req: any, res: Response) => {
        const { id } = req.params;

        this.userService.delete(id)
            .then(() => res.status(202).json({ message: 'Usuario Eliminado' }))
            .catch(error => this.handleError(error, res));
    }

}
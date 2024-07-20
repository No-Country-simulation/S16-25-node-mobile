import { UpdateUser, UserModel, UserRequest } from "../models/user.model";
import bcrypt from 'bcryptjs';
import { handleUpload } from "../utils/imageUpload";
import { CustomError } from "../utils/custom.error";

export class UserService {
    constructor() {}

    async getUsers() {
        const [total, users] = await Promise.all([
			UserModel.countDocuments(),
			UserModel.find().select('-password -token -createdAt -updatedAt -__v')
		]);

		return { total, users };
    }

    async create(data: UserRequest) {
		const hashedPassword = await bcrypt.hash(data.password, 10);
		const imageUrl = await handleUpload(data.imagenPerfil);

		const tempUser = {
			...data,
			password: hashedPassword,
			imagenPerfil: imageUrl
		};

		const saveUser = new UserModel(tempUser);
		await saveUser.save();

		return saveUser;
	}

	async getById(id: string) {
		const findUser = await UserModel.findById(id);

		if (!findUser) {
			throw CustomError.notFound('Usuario no encontrado');
		}

		return findUser;
	}

	async update(id: string, data: UpdateUser) {
		const userExists = await UserModel.findById(id);

		if (!userExists) {
			throw CustomError.notFound('El usuario no existe');
		}

		if (data.password) {
			data.password = await bcrypt.hash(data.password, 10);
		}

		if (data.imagenPerfil) {
			const imageUrl = await handleUpload(data.imagenPerfil);

			/* data.imagenPerfil = imageUrl; */
		}

		await UserModel.findByIdAndUpdate(id, data);

		const user = await UserModel.findById(id);

		return user;
	}

	async delete(id: string) {
		const findUser = await UserModel.findById(id);

		if (!findUser) {
			throw CustomError.notFound('Usuario no encontrado');
		}

		await UserModel.deleteOne({ _id: findUser.id });
	}
    
    /* async function getMoreData(data) {
      return Promise.resolve(data + 'more data');
    }
    
    async function getAll() {
      const data = await getData();
      const moreData = await getMoreData(data);
      return `All the data: ${data}, ${moreData}`;
    }
    
    getAll().then((all) => {
      console.log('all the data')
    }) */
}
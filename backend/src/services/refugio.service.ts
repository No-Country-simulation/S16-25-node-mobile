import { ObjectId } from 'mongoose';
import {
	RefugioModel,
	RefugioRequest,
	UpdateRefugioRequest
} from '../models/refugio.model';
import { UserModel } from '../models/user.model';
import { CustomError } from '../utils/custom.error';
import { handleUpload } from '../utils/imageUpload';

export class RefugioService {
	constructor() {}

	async geAll() {
		const [total, refugios] = await Promise.all([
			RefugioModel.countDocuments(),
			RefugioModel.find()
		]);

		return { total, refugios };
	}

	async create(data: RefugioRequest) {
		const [gerenteExists, correoExists, telefonoExists] = await Promise.all([
			UserModel.findById(data.gerente),
			RefugioModel.findOne({ correo: data.correo }),
			RefugioModel.findOne({ telefono: data.telefono })
		]);

		if (!gerenteExists) {
			throw CustomError.badRequest('El gerente no existe');
		}

		if (correoExists) {
			throw CustomError.badRequest('El correo ya existe');
		}

		if (telefonoExists) {
			throw CustomError.badRequest('El telefono ya existe');
		}

		const imageUrl = await handleUpload(data.image);

		const tempRefugio = { ...data, image: imageUrl };

		const newRefugio = new RefugioModel(tempRefugio);
		await newRefugio.save();

		return newRefugio;
	}

	async getById(id: string) {
		const refugioExists = await RefugioModel.findById(id);

		if (!refugioExists) {
			throw CustomError.notFound('El refugio no existe');
		}

		return refugioExists;
	}

	async update(id: string, data: UpdateRefugioRequest) {
		const refugioExists = await this.getById(id);

		if (data.image) {
			const imageUrl = await handleUpload(data.image);

			const tempRefugio = { ...data, image: imageUrl };

			await RefugioModel.updateOne({ id: refugioExists.id }, tempRefugio);
		} else {
			await RefugioModel.updateOne({ id: refugioExists.id }, data);
		}

		const updatedRefugio = await this.getById(refugioExists.id);

		return updatedRefugio;
	}

	async delete(id: string) {
		const refugioExists = await this.getById(id);

		await RefugioModel.deleteOne({ id: refugioExists.id });
	}
}

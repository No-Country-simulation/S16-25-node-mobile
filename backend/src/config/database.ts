import mongoose from 'mongoose';

interface Options {
	mongoUrl: string;
	dbName: string;
}

export class MongoDatabase {
	static async connect(options: Options) {
		const { mongoUrl, dbName } = options;

		try {
			await mongoose.connect(mongoUrl, { dbName });
			return true;
		} catch (error) {
			console.log('Mongo connection error');
		}
	}

	static async disconnect() {
		await mongoose.disconnect();
	}
}

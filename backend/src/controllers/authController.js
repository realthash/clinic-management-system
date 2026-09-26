import { prisma } from "../config/db.js";
import bcrypt from 'bcrypt'

//TODO: complete the req.body checking the schema
//TODO: use jwt web token
const registerUser = async (req, res) => {
    const { name, email, password, nic, phone } = req.body;

    console.log(password)
    const userExist = await prisma.patient.findUnique({ where: { email: email } });
    if (userExist) {
        return res.status(400).json({ message: "User exist with the email" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt)

    const user = await prisma.patient.create({
        data: {
            name,
            email,
            password: hashedPassword,
            nic,
            phone
        }
    })
    res.status(201).json({ status: "success", data: user })
}

export { registerUser };
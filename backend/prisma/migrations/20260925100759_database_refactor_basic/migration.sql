/*
  Warnings:

  - You are about to drop the column `category` on the `session` table. All the data in the column will be lost.
  - You are about to drop the `session_booking` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `clinic_id` to the `session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `session_capacity` to the `session` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "session_booking" DROP CONSTRAINT "session_booking_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "session_booking" DROP CONSTRAINT "session_booking_session_id_fkey";

-- AlterTable
ALTER TABLE "session" DROP COLUMN "category",
ADD COLUMN     "clinic_id" TEXT NOT NULL,
ADD COLUMN     "description" TEXT,
ADD COLUMN     "session_capacity" INTEGER NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "venue" DROP NOT NULL;

-- DropTable
DROP TABLE "session_booking";

-- CreateTable
CREATE TABLE "clinic" (
    "id" TEXT NOT NULL,
    "department_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT,

    CONSTRAINT "clinic_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "session_patient" (
    "id" TEXT NOT NULL,
    "booking_type" "Status" NOT NULL,
    "status" "Active_status" NOT NULL,
    "session_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "session_patient_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "clinic" ADD CONSTRAINT "clinic_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "department"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_clinic_id_fkey" FOREIGN KEY ("clinic_id") REFERENCES "clinic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_patient" ADD CONSTRAINT "session_patient_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "session"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_patient" ADD CONSTRAINT "session_patient_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

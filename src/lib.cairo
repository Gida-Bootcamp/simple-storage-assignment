// Write a starknet contract that
// 1. stores name and age of a student in the contract's state
// 2. allows users to update the value of the name and age of the student
// 3. allows users to retrieve the stored value (name and age of the stude)

/// Interface representing Student Storage Contract
#[starknet::interface]
pub trait ISimpleStorageContract<TContractState> {
    /// Updates student's information.
    fn update_student_data(ref self: TContractState, name: ByteArray, age: u16);
    /// Retrieves student's information.
    fn retrieve_student_data(self: @TContractState) -> (ByteArray, u16);
}

/// Simple contract for managing student data.
#[starknet::contract]
mod SimpleStorageContract {
    

    use starknet::storage::StoragePointerReadAccess;
use starknet::storage::StoragePointerWriteAccess;
#[storage]
    struct Storage {
        student_name: ByteArray,
        student_age: u16,
    }

    #[abi(embed_v0)]
    impl SimpleStorageContractImpl of super::ISimpleStorageContract<ContractState> {
        fn update_student_data(ref self: ContractState, name: ByteArray, age: u16) {
            // Update storage variables directly
            self.student_name.write(name);
            self.student_age.write(age);
        }

        fn retrieve_student_data(self: @ContractState) -> (ByteArray, u16) {
            // Read storage variables directly
            (self.student_name.read(), self.student_age.read())
        }
    }
}
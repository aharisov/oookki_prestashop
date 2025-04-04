function applyInputMask(input: HTMLInputElement, pattern: string) {
    input.addEventListener("input", (event) => {
        const target = event.target as HTMLInputElement;
        let value = target.value.replace(/\s+/g, "").toUpperCase(); // Remove spaces and force uppercase if needed
        let maskedValue = "";
        let patternIndex = 0;
        let valueIndex = 0;

        while (patternIndex < pattern.length && valueIndex < value.length) {
            if (pattern[patternIndex] === "0") {
                // Only numbers allowed
                if (/\d/.test(value[valueIndex])) {
                    maskedValue += value[valueIndex++];
                } else {
                    valueIndex++; // Skip invalid character
                    continue;
                }
            } else if (pattern[patternIndex] === "X") {
                // Any alphanumeric character
                if (/[A-Z0-9]/.test(value[valueIndex])) {
                    maskedValue += value[valueIndex++];
                } else {
                    valueIndex++; // Skip invalid character
                    continue;
                }
            } else {
                // Add predefined character from pattern
                maskedValue += pattern[patternIndex];
            }
            patternIndex++;
        }

        target.value = maskedValue;
    });
}

const inputPhone = document.getElementById("phone-number") as HTMLInputElement;
const inputRio = document.getElementById("phone-rio") as HTMLInputElement;
const inputBirthDate = document.getElementById("birth-date") as HTMLInputElement;
const inputPostalCode = document.getElementById("postal-code") as HTMLInputElement;

if (inputPhone) applyInputMask(inputPhone, "00 00 00 00 00");
if (inputRio) applyInputMask(inputRio, "00 X XXXXXX 0X0");
if (inputBirthDate) applyInputMask(inputBirthDate, "00/00/0000");
if (inputPostalCode) applyInputMask(inputPostalCode, "00000");
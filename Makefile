TARGET = calculator-asm
SRC = $(wildcard *.s)
OBJ = $(SRC:.s=.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	ld -o $@ $(OBJ) -e _start   # link all object files, entry point _start

%.o: %.s
	as $< -o $@

clean:
	rm -f $(OBJ)


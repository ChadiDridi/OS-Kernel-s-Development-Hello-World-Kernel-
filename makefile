GPPPARMAMS=	-m64 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fPIC -I./include
ASPARAMS=	--64
objects =	loader.o kernel.o
LDPARAMS=	-melf_x86_64
%.o:	%.cpp
	g++	$(GPPPARMAMS) -o $@ -c $<

%o:	%.s

	as $(ASPARAMS) -o $@ $< 
mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install:	mykernel.bin
	sudo cp $< /boot/mykernel.bin 
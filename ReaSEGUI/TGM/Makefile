GCC = g++
CFLAGS = -g
LIBS = -lm 
LDFLAGS = $(LDPATH) $(LIBS)

#Set statistics for powerlaws on/off
#POWERLAWS = TRUE

SRC = TopologyNode.cpp TGM.cpp RNode.cpp ASNode.cpp
#DEPS := $(patsubst %.o,%.d,$(OBJS))

ifeq "$(POWERLAWS)" "TRUE"
	CFLAGS+= -DSTATISTICS
	CFLAGS+= -I./gsl
	LIBS+= -lgsl -lgslcblas
	LDFLAGS+=-L./gsl/.libs -L./gsl/cblas/.libs/
endif

all: tgm
	@echo "done!"

.PHONY: depend
depend: $(SRC)
	$(GCC) $(CFLAGS) -MM $(SRC)  > make.depend
	

tgm: TGM.o ASNode.o TopologyNode.o RNode.o  
	$(GCC) $(CFLAGS) TGM.o ASNode.o TopologyNode.o RNode.o $(LDFLAGS) -o $@

%.o: %.cpp
	$(GCC) $(CFLAGS) -c $< -o $@
	
.PHONY: clean
clean:
	rm *.o
	rm tgm



include make.depend
